<g:if test="${existe}">
    <table class="table-condensed table-bordered table-striped table-hover" style="margin-top: 20px; width: 100%">
        <thead style="text-align: center; background-color: #435a83; color: #fff;">
        <tr>
            <th width="9%" style="text-align: center">Hora</th>
            <g:each in="${dias}" var="d" status="i">
                <th width="13%" style="text-align: center" class="${i == indice ? 'clase_hoy':''}">${d?.nombre} ${(semana?.fechaInicio + i).format('dd-MMM')}</th>
            </g:each>
        </tr>
        </thead>
        <tbody>
        <g:each in="${horario}" var="h">
            <tr data-id="${h?.lun?.split(';')[0]}" >
            <td width="9%" style="font-weight: bold; background-color: #435a83; color: #fff;">${h?.hora}</td>
            <g:if test="${h?.lun?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.lun?.split(';')[3])}
                    <a href="#" data-agnd="${h?.lun?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>

            <g:if test="${h?.mar?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.mar?.split(';')[3])}
                    <a href="#" data-agnd="${h?.mar?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>

            <g:if test="${h?.mie?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.mie?.split(';')[3])}
                    <a href="#" data-agnd="${h?.mie?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>

            <g:if test="${h?.jue?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.jue?.split(';')[3])}
                    <a href="#" data-agnd="${h?.jue?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>

            <g:if test="${h?.vie?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.vie?.split(';')[3])}
                    <a href="#" data-agnd="${h?.vie?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>

            <g:if test="${h?.sab?.size() > 10}">
                <td width="10%" class="agendado">${raw(h?.sab?.split(';')[3])}
                    <a href="#" data-agnd="${h?.sab?.split(';')[2]}" class="btn btn-xs btn-info btnVerCita"
                       title="Ver detalle de la cita" style="float: right"><i class="fa fa-clipboard-check"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre">Libre</td>
            </g:else>


        </g:each>

        </tr>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="alert alert-danger" style="text-align: center"> <i class="fa fa-exclamation-triangle fa-2x text-info"></i>
        <strong style="font-size: 14px"> Seleccione un paralelo  </strong>
    </div>
</g:else>


<script type="text/javascript">
    $(".btnVerCita").click(function () {
        var agenda = $(this).data("agnd");
        console.log('agenda', agenda)
        %{--location.href="${createLink(controller: 'agenda', action: 'redireccion_ajax')}?id=" + id--}%
    });
</script>
