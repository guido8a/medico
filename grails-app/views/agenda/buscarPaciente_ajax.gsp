<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 5px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-4">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPorPaciente" class="buscarPorPaciente col-md-12 form-control" from="${[ 1: 'Nombre', 2: 'Apellido', 3: 'Cédula']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterioPaciente" id="criterioPaciente" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarListaPacientes"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiarListaPacientes" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaPacientes" >
        </div>
    </fieldset>

    <fieldset style="border-radius: 4px; margin-top: 5px">
        <div class="alert alert-warning">
            * Máxima cantidad de registros en pantalla 100
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    cargarListaPacientes();

    $("#buscarPorPaciente").change(function () {
        cargarListaPacientes();
    });

    $("#btnBuscarListaPacientes").click(function () {
        cargarListaPacientes();
    });

    $("#btnLimpiarListaMedicina").click(function () {
        $("#criterioPaciente").val('');
        $("#buscarPorPaciente").val(1);
        cargarListaPacientes();
    });

    function cargarListaPacientes(){
        var e = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPorPaciente option:selected").val();
        var criterio = $("#criterioPaciente").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'agenda', action: 'tablaListaPacientes_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio
            },
            success: function (msg){
                e.modal("hide");
                $("#divTablaPacientes").html(msg)
            }
        })
    }

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarListaPacientes();
            return false;
        }
        return true;
    })

</script>