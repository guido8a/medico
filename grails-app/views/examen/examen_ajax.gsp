
<style>

/*.wrap {*/
/*    height: 310px;*/
/*    display: flex;*/
/*    flex-direction: column;*/
/*    flex-wrap: wrap;*/
/*}*/

</style>

<div class="form-group">
    <span class="grupo">
        <label class="col-md-2 control-label text-info">
            Exámenes
        </label>
        <g:if test="${examenes.size() > 0}">
            <span class="col-md-9" style=" border-style: solid; border-color: #AAA; border-width: 2px; height: 320px; overflow-y: auto; margin-left: 25px">
                <table style="width: 100%">
                    <tbody class="wrap">
                    <g:each in="${examenes}" status="i" var="examen">
                        <tr style="max-width: 50%">
                            <td >
                                <g:checkBox class="c1" name="c2_${examen?.id}" checked="${chequeados?.contains(examen) ? 'true' : 'false'}"/> ${examen?.descripcion}
                                <strong style="color: #ff5234"> ${ ' GRUPO: ' + examen?.tipoExamen?.grupoExamen?.descripcion} </strong>
                                <strong style="color: #0c6cc2"> ${ ' - TIPO: ' + examen?.tipoExamen?.descripcion} </strong>
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