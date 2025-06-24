<div class="modal-contenido">
    <div class="form-group keeptogether">
        <div class="col-md-12">
            %{--        <span class="grupo">--}%
            %{--            <div class="col-md-2">--}%
            %{--                <label class="control-label">--}%
            %{--                    Paciente--}%
            %{--                </label>--}%
            %{--            </div>--}%
            %{--            <div class="col-md-10" id="divPacientes">--}%
            %{--                <g:select name="paciente" from="${pacientes}" class="form-control" optionKey="id"--}%
            %{--                          optionValue="${{it.apellido + " " + it.nombre}}"/>--}%
            %{--            </div>--}%
            %{--        </span>--}%



            <div class="col-md-2">
                <label class="control-label text-info" style="margin-top: 10px">Paciente:</label>
            </div>

            <div class="col-md-8">
                <g:hiddenField name="paciente" class="form-control" />
                <g:textField name="pacienteName" class="form-control" readonly=""/>
            </div>

            <div class="col-md-1">
                <button class="btn btn-info" id="btnBuscarPaciente"><i class="fa fa-search"></i> Buscar
                </button>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">

    var lp;

    $("#btnBuscarPaciente").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reportes', action:'buscarPaciente_ajax')}",
            data    : {
            },
            success : function (msg) {
                lp = bootbox.dialog({
                    id      : "dlgBuscarPaciente",
                    title   : "Buscar Paciente",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }); //createEdit

    function cerrarBuscarPaciente(){
        lp.modal("hide");
    }

</script>