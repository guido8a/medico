<g:if test="${profesor}">
    <div class="col-md-12 text-info" style="font-weight: bold; font-size: 14px">DOCTOR:
        <span style="color:#0070B0">${profesor?.apellido} ${profesor?.nombre}</span>
    </div>
</g:if>
<g:else>
    <div class="col-md-12 text-danger">Sin doctor seleccionado</div>
</g:else>
<g:if test="${existe}">
    <table class="table-condensed table-bordered table-striped table-hover" style="margin-top: 20px; width: 100%">
        <thead style="text-align: center; background-color: #435a83; color: #fff;">
        <tr>
            <th width="9%" style="text-align: center">Hora</th>
            <g:each in="${dias}" var="d">
                <th width="13%" style="text-align: center">${d?.nombre}</th>
            </g:each>
        </tr>
        </thead>
        <tbody>
        <g:each in="${horario}" var="h">
            <tr data-id="${h?.lun?.split(';')[0]}" >
            <td width="9%" style="font-weight: bold; background-color: #435a83; color: #fff;">${h?.hora}</td>
            <g:if test="${h?.lun?.size() > 10}">
                <td width="10%" data-id="${h?.lun?.split(';')[2]}" class="${h?.lun?.split(';')[3] == 'S' ? 'usado' : 'otro'}">
                    ${h?.lun?.split(';')[4]}
                    <a href="#" data-hora="${h?.lun?.split(';')[2]}" class="btn btn-xs btn-danger btn-borra-hora "
                       title="Eliminar">
                        <i class="fa fa-trash"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.lun?.split(';')[0]}" data-hora="${h?.lun?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.mar?.size() > 10}">
                <td width="10%" data-id="${h?.mar?.split(';')[2]}"  class="${h?.mar?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.mar?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.mar.split(';')[5][0..12]}.. - ${h.mar.split(';')[4]}
                    <a href="#" data-hora="${h?.mar?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"> </i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.mar?.split(';')[0]}" data-hora="${h?.mar?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.mie?.size() > 10}">
                <td width="10%" data-id="${h?.mie?.split(';')[2]}"  class="${h?.mie?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.mie?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.mie.split(';')[5][0..12]}.. - ${h.mie.split(';')[4]}
                    <a href="#" data-hora="${h?.mie?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.mie?.split(';')[0]}" data-hora="${h?.mie?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.jue?.size() > 10}">
                <td width="10%" data-id="${h?.jue?.split(';')[2]}"  class="${h?.jue?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.jue?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.jue.split(';')[5][0..12]}.. - ${h.jue.split(';')[4]}
                    <a href="#" data-hora="${h?.jue?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.jue?.split(';')[0]}" data-hora="${h?.jue?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.vie?.size() > 10}">
                <td width="10%" data-id="${h?.vie?.split(';')[2]}"  class="${h?.vie?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.vie?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.vie.split(';')[5][0..12]}.. - ${h.vie.split(';')[4]}
                    <a href="#" data-hora="${h?.vie?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.vie?.split(';')[0]}" data-hora="${h?.vie?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.sab?.size() > 10}">
                <td width="10%" data-id="${h?.sab?.split(';')[2]}"  class="${h?.sab?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.sab?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.sab.split(';')[5][0..12]}.. - ${h.sab.split(';')[4]}
                    <a href="#" data-hora="${h?.sab?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.sab?.split(';')[0]}" data-hora="${h?.sab?.split(';')[1]}">
                    Libre
                </td>
            </g:else>

            <g:if test="${h?.dom?.size() > 10}">
                <td width="10%" data-id="${h?.dom?.split(';')[2]}"  class="${h?.dom?.split(';')[3] == 'S' ? 'usado' : 'otro'} ${h?.dom?.split(';')[6] == 'S' ? 'conjunta' : '' }">
                    ${h.dom.split(';')[5][0..12]}.. - ${h.dom.split(';')[4]}
                    <a href="#" data-hora="${h?.dom?.split(';')[2]}" class= "btn btn-xs btn-danger btn-borra-hora"
                       title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td width="10%" class="horas libre"
                    data-dia="${h?.dom?.split(';')[0]}" data-hora="${h?.dom?.split(';')[1]}">
                    Libre
                </td>
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
    $(".horas").click(function () {
        var dias = $(this).data("dia");
        var hora = $(this).data("hora");
        creaHora(dias, hora)
    });

    $(".btn-borra-hora").click(function () {
        var id = $(this).data("hora");
        borraHora(id)
    });

</script>
