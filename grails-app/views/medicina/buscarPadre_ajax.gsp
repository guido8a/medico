<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
%{--                <span class="col-md-4">--}%
%{--                    <label class="control-label text-info">Buscar Por</label>--}%
%{--                    <g:select name="buscarPorPadre" class="buscarPorPadre col-md-12 form-control" from="${[1: 'Nombre', 2: 'Código']}" optionKey="key"--}%
%{--                              optionValue="value"/>--}%
%{--                </span>--}%
                <span class="col-md-8">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterioPadre" id="criterioPadre" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarListaPadre"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiarPadre" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaPadres" >
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#btnBuscarListaPadre").click(function () {
        cargarPadres();
    });

    $("#btnLimpiarPadre").click(function () {
        $("#criterioPadre").val('');
        $("#buscarPorPadre").val(1);
        cargarPadres();
    });

    cargarPadres();

    function cargarPadres(){
        var e = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPorPadre option:selected").val();
        var criterio = $("#criterioPadre").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'medicina', action: 'tablaPadres_ajax')}',
            data:{
                // buscarPor: buscarPor,
                criterio: criterio
            },
            success: function (msg){
                e.modal("hide");
                $("#divTablaPadres").html(msg)
            }
        })
    }

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarPadres();
            return false;
        }
        return true;
    })

</script>