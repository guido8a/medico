<h4>Exámenes Cita Anterior ${} </h4>
<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <div style="width:96%; float: right">
        <table class="table-bordered table-condensed table-success" style="width: 100%">
            <tbody>
            <tr style="font-size: 16px">
                <td style="width: 80%; background-color:#b7d6a9">
                    <g:if test="${examenes.size() > 0}">
                        <table class="table table-bordered table-striped table-condensed table-hover table-success">
                            <thead>
                            <tr style="width: 100%">
                                <th style="width: 15%">Grupo </th>
                                <th style="width: 15%">Tipo </th>
                                <th style="width: 15%">Examen</th>
                                <th style="width: 10%">Fecha </th>
                                <th style="width: 25%">Observaciones</th>
                                <th style="width: 10%">Documento</th>
                            </tr>
                            </thead>
                            <tbody >
                            <g:each in="${examenes}" status="i" var="examen">
                                <tr>
                                    <td style="width: 15%">${examen?.tipoExamen?.grupoExamen?.descripcion}</td>
                                    <td style="width: 25%">${examen?.tipoExamen?.descripcion}</td>
                                    <td style="width: 25%">
                                        <ul>
                                            <g:each in="${medico.DetalleExamen.findAllByExamenComplementario(examen)}">
                                                <li>
                                                    ${it?.examen?.descripcion}
                                                </li>
                                            </g:each>
                                        </ul>
                                    </td>
                                    <td style="width: 10%">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                                    <td style="width: 25%">${examen?.observaciones}</td>
                                    <td style="width: 10%; text-align: center">
                                        <g:if test="${examen?.path}">
                                            ${examen?.path}
                                        </g:if>
                                        <g:if test="${examen?.path}">
                                            <g:link controller="historial" action="downloadFile" class="btn btn-warning btn-xs btn-docs" rel="tooltip" title="Descargar" id="${examen.id}">
                                                <i class="fa fa-download"></i>
                                            </g:link>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin exámenes de una cita anterior</div>
                    </g:else>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">


</script>