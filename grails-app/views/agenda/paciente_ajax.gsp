<g:form class="form-horizontal" name="frmAgenda" role="form" controller="agenda" action="saveAgenda_ajax" method="POST">
    <g:hiddenField name="semana" value="${semana?.id}" />
    <g:hiddenField name="persona" value="${persona?.id}" />
    <g:hiddenField name="dias" value="${dia?.id}" />
    <g:hiddenField name="hora" value="${hora?.id}" />
    <g:hiddenField name="id" value="${agenda?.id}" />

    <div class="form-group">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Paciente
            </label>
            <span class="col-md-8">
                <g:hiddenField name="paciente" value="${agenda?.paciente?.id}"/>
                <g:textField name="pacienteNombre" class="form-control " readonly="" value="${agenda?.paciente ? (agenda?.paciente?.apellido + " " + agenda?.paciente?.nombre) : ''}"/>
            </span>
            <span class="col-md-2">
                <a href="#" id="btnBuscarPaciente" class="btn btn-sm btn-info" style="" title="Buscar paciente">
                    <i class="fa fa-search"></i> Buscar
                </a>
            </span>
        </span>
    </div>

    <div class="form-group">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-10">
                <g:textArea name="observaciones" style="resize: none; height: 100px" maxlength="255" class="form-control" value="${agenda?.observaciones}" />
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    var dpcnt;

    $("#btnBuscarPaciente").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'agenda', action:'buscarPaciente_ajax')}",
            data    : {},
            success : function (msg) {
                dpcnt = bootbox.dialog({
                    id      : "dlgBuscarPaciente",
                    title   : "Buscar Paciente",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarBusquedaPaciente(){
        dpcnt.modal("hide");
    }

</script>