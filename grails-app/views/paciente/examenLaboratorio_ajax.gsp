<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed table-success" style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 20%;font-weight: bolder" class="alert alert-success">Exámenes de laboratorio:</td>
            <td style="width: 80%; background-color:#b7d6a9">
                <g:if test="${examenes.size() > 0}">
                    <table class="table table-bordered table-striped table-condensed table-hover table-success">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 25%">Descripción </th>
                            <th style="width: 10%">Fecha </th>
                            <th style="width: 25%">Observaciones</th>
                            <th style="width: 25%">Documento asociado</th>
                        </tr>
                        </thead>
                        <tbody >
                        <g:each in="${examenes}" status="i" var="examen">
                            <tr>
                                <td style="width: 25%">${examen?.examen?.descripcion}</td>
                                <td style="width: 10%">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                                <td style="width: 25%">${examen?.observaciones}</td>
                                <td style="width: 25%">
                                    <g:if test="${examen?.path}">
                                        ${examen?.path}
                                    </g:if>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    <div class="alert alert-success"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> La cita no contiene exámenes</div>
                </g:else>
            </td>
        </tr>
        </tbody>
    </table>
</div>