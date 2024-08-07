<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 5px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-3">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor-geo" class="buscarPor form-control"
                              from="['1': 'Provincia', '2': 'Cantón', '3': 'Parroquia']"
                              style="" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterio-geo" class="criterio form-control"/>
                </span>
                <span class="col-md-3">
                    <label class="control-label text-info">Ordenar</label>
                    <g:select name="ordenar-geo" class="ordenar form-control" from="['1': 'Ascendente', '2': 'Descendente']"
                              style="" optionKey="key"
                              optionValue="value"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px; margin-left: -10px">
                <button class="btn btn-info" id="btn-consultar-geo"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px; margin-left: -10px">
                <button class="btn btn-warning" id="btnLimpiarListaGeo" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px; margin-top: 20px">
        <div id="divTablaGeo">
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    cargarLugarNacimiento();

    $("#btnLimpiarListaGeo").click(function () {
        var buscarPor = $("#buscarPor-geo").val('1');
        var criterio = $("#criterio-geo").val('');
        var ordenar = $("#ordenar-geo").val('1');
        cargarLugarNacimiento();
    });

    $("#btn-consultar-geo").click(function () {
        cargarLugarNacimiento();
    });

    function cargarLugarNacimiento(){
        var ln = cargarLoader("Cargando...");
        var buscar = $("#buscarPor-geo option:selected").val();
        var criterio = $("#criterio-geo").val();
        var ordenar = $("#ordenar-geo option:selected").val();
        $.ajax({
            type: "POST",
            url: "${createLink(action:'situacionGeografica')}",
            data: {
                buscarPor: buscar,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                ln.modal("hide");
                $("#divTablaGeo").html(msg);
                $("#dlgLoad").dialog("close");
            }
        });
    }

    $("#buscarPor-geo, #ordenar-geo").change(function () {
        cargarLugarNacimiento();
    });

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarLugarNacimiento();
            return false;
        }
        return true;
    })


</script>