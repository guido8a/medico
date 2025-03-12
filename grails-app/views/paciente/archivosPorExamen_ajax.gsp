<div class="row">
    <div class="col-md-12">
        <div role="main">
            <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <thead>
                <tr style="width: 100%">
                    <th style="width: 30%">Examen</th>
                    <th style="width: 15%">Fecha</th>
                    <th style="width: 40%">Nombre del Archivo</th>
                    <th style="width: 15%">Archivo</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="" style="width: 99.7%;height: 250px; overflow-y: auto;float: right; margin-top: -20px">
            <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <tbody>
                <g:if test="${examenes.size() > 0}">
                    <g:each in="${examenes}" status="i" var="examen">
                        <tr style="width: 100%">
                            <td style="width: 30%">
                                <ul>
                                    <g:each in="${medico.DetalleExamen.findAllByExamenComplementario(examen)}">
                                        <li>
                                            ${it?.examen?.descripcion}
                                        </li>
                                    </g:each>
                                </ul>
                            </td>
                            <td style="width: 15%">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                            <td style="width: 40%">${examen?.path}</td>
                            <td style="width: 15%; text-align: center">
                                <a class="btn btn-info btn-xs btnCargarDocumento" href="#" rel="tooltip" title="Subir documento" data-id="${examen.id}">
                                    <i class="fa fa-upload"></i>
                                </a>
                                <g:link controller="historial" action="downloadFile" class="btn btn-warning btn-xs btn-docs" rel="tooltip" title="Descargar" id="${examen.id}">
                                    <i class="fa fa-download"></i>
                                </g:link>
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

    $(".btnCargarDocumento").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'historial', action:'formDocExamenes_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                cd = bootbox.dialog({
                    id      : "dlgDoc",
                    title   : "Documento del examen",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

</script>