<div>
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 5px">
        <div class="row-fluid" style="margin-left: 10px">
            <div class="col-md-12">
                <div class="col-md-1">
                    <label class="control-label text-info" style="margin-top: 10px">Buscar por:</label>
                </div>

                <div class="col-md-6">
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </div>

                <div class="col-md-3">
                    <button class="btn btn-info" id="btnBuscarEmpresa"><i class="fa fa-search"></i> Buscar pacientes
                    </button>
                </div>

                <div class="col-md-1" >
                    <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i
                            class="fa fa-eraser"></i>
                    </button>
                </div>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaPacientes">
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#btnLimpiar").click(function () {
        $("#criterio").val('');
        cargarTablaPacientes();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaPacientes();
            return false;
        }
        return true;
    });

    cargarTablaPacientes();

    function cargarTablaPacientes() {
        var d = cargarLoader("Cargando...");
        var criterio = $("#criterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'tablaPacientes_ajax')}',
            data: {
                criterio: criterio
            },
            success: function (msg) {
                d.modal("hide");
                $("#divTablaPacientes").html(msg)
            }
        })
    }

</script>