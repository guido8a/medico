<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 5px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Tipo</label>
                    <g:select name="tipoMedicina" class="col-md-12 form-control" from="${['G': 'Genérico', 'C': 'Comercial']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPorMedicina" class="buscarPorMedicina col-md-12 form-control" from="${[ 1: 'Nombre', 2: 'Descripción', 3: 'Código']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterioMedicina" id="criterioMedicina" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarListaMedicina"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiarListaMedicina" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaMedicina" >
        </div>
    </fieldset>

    <fieldset style="border-radius: 4px; margin-top: 5px">
        <div class="alert alert-warning">
            * Máxima cantidad de registros en pantalla 100
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    cargarMedicinas();

    $("#tipoMedicina").change(function () {
        cargarMedicinas();
    });

    $("#buscarPorMedicina").change(function () {
        cargarMedicinas();
    });

    $("#btnBuscarListaMedicina").click(function () {
        cargarMedicinas();
    });

    $("#btnLimpiarListaMedicina").click(function () {
        $("#criterioMedicina").val('');
        $("#buscarPorMedicina").val(1);
        $("#tipoMedicina").val('G');
        cargarMedicinas();
    });

    function cargarMedicinas(){
        var e = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPorMedicina option:selected").val();
        var criterio = $("#criterioMedicina").val();
        var tipoMedicina = $("#tipoMedicina option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tratamiento', action: 'tablaMedicina_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio,
                tipoMedicina: tipoMedicina
            },
            success: function (msg){
                e.modal("hide");
                $("#divTablaMedicina").html(msg)
            }
        })
    }

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarMedicinas();
            return false;
        }
        return true;
    })

</script>