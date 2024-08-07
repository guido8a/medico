<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <thead>
        <tr>
            <th style="background-color: ${colorProv}; width: 25%">Provincia</th>
            <th style="background-color: ${colorCant};width: 25%">Cantón</th>
            <th style="background-color: ${colorParr};width: 35%">Parroquia</th>
            <th style="width: 15%;">Seleccionar</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${comunidades}">
            <g:each in="${comunidades}" var="comn" status="i">
                <tr>
                    <td style="width: 25%;">${comn.provnmbr}</td>
                    <td style="width: 25%;">${comn.cntnnmbr}</td>
                    <td style="width: 35%;">${comn.parrnmbr}</td>
                    <td style="width: 15%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnSeleccionarGeo" title="Seleccionar" data-id="${comn?.parr__id}"
                           data-parroquia="${comn?.parrnmbr}" data-canton="${comn?.cntnnmbr}" data-provincia="${comn?.provnmbr}" >
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccionarGeo").click(function () {
        var parroquia = $(this).data("parroquia");
        var canton = $(this).data("canton");
        var provincia = $(this).data("provincia");
        var idParroquia = $(this).data("id");

        $("#parroquia").val(idParroquia);
        $("#parroquiaNombre").val(parroquia);
        $("#canton").val(canton);
        $("#provincia").val(provincia);

        cerrarLugarNacimiento();
    });

</script>
