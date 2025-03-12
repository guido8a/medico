<div class="row">
    <div class="col-md-12">
        <div role="main">
            <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <thead>
                <tr style="width: 100%">
                    <th style="width: 75%">Cita</th>
                    <th style="width: 15%">Fecha</th>
                    <th style="width: 10%">Exámenes</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="" style="width: 99.7%;height: 250px; overflow-y: auto;float: right; margin-top: -20px">
            <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <tbody>
                <g:if test="${citas.size() > 0}">
                    <g:each in="${citas}" status="i" var="cita">
                        <tr style="width: 100%">
                            <td style="width: 75%">${cita?.motivo}</td>
                            <td style="width: 15%">${cita?.fecha?.format("dd-MM-yyyy")}</td>
                            <td style="width: 10%; text-align: center">
                                <a class="btn btn-success btn-xs btnVerArchivos" href="#" rel="tooltip" title="Ver archivos de exámenes" data-id="${cita.id}">
                                    <i class="fa fa-list"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <div class="alert alert-warning" style="text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
                </g:else>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">

    var va;

    $(".btnVerArchivos").click(function () {
        var cita = $(this).data("id");
        cargarVerArchivos(cita)
    });

    function cargarVerArchivos(cita){
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'paciente', action:'archivosPorExamen_ajax')}",
            data    : {
                id: cita
            },
            success : function (msg) {
                va = bootbox.dialog({
                    id      : "dlgVerArchivosExamenes",
                    title   : "Histórico Archivos Exámenes",
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
    }

    function cerrarVerArchivos(){
        va.modal("hide")
    }


</script>