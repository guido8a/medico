
<div class="tab-content" style="margin-top: 10px">
    <div id="home" class="tab-pane fade in active">
        <g:form class="form-horizontal" name="frmDiagnostico" controller="historial" action="saveDiagnostico_ajax">
            <g:hiddenField name="id" value="${historial?.id}"/>
            <g:hiddenField name="diagnostico" value="${historial?.diagnostico?.id}"/>

            <div class="row izquierda">
                <div class="col-md-12 input-group">
                    <span class="col-md-2 label label-primary text-info mediano">Código</span>
                    <span class="col-md-4">
                        <g:textField name="diagnosticoCodigo" readonly="" class="form-control"  value="${historial?.diagnostico?.codigo}"/>
                    </span>
                </div>
            </div>

            <div class="row izquierda">
                <div class="col-md-12 input-group">
                    <span class="col-md-2 label label-primary text-info mediano">Diagnóstico</span>
                    <span class="col-md-8">
                        <g:textArea name="diagnosticoNombre" readonly="" style="resize: none; height: 100px;" class="form-control"  value="${historial?.diagnostico?.descripcion}"/>
                    </span>
                    <span class="col-md-2">
                        <a href="#" id="btnBuscarDiagnostico" class="btn btn-sm btn-info" style="" title="Buscar diagnóstico">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </span>
                </div>
            </div>
        </g:form>
    </div>
</div>

<script type="text/javascript">

    var dp;

    $("#btnBuscarDiagnostico").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'buscarDiagnostico_ajax')}",
            data    : {},
            success : function (msg) {
                dp = bootbox.dialog({
                    id      : "dlgBuscarDiagnostico",
                    title   : "Buscar diagnóstico",
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

    function cerrarBusqueda(){
        dp.modal("hide");
    }

</script>