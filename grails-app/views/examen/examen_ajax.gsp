<div class="form-group">
    <span class="grupo">
        <label class="col-md-2 control-label text-info">
            Exámenes
        </label>
        <g:if test="${examenes.size() > 0}">
            <span class="col-md-8" style=" border-style: solid; border-color: #AAA; border-width: 2px; margin-left: 25px">
                <table>
                    <tbody >
                    <g:each in="${examenes}" status="i" var="examen">
                        <tr style="width: 100%">
                            <td>
                                <g:checkBox class="c1" name="c2_${examen?.id}" checked="${chequeados?.contains(examen) ? 'true' : 'false'}"/> ${examen?.descripcion}
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </span>
        </g:if>
        <g:else>
            <span class="col-md-8" style="margin-left: 10px">
                <div class="alert alert-warning"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
            </span>
        </g:else>
</div>