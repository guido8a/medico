%{--<html>--}%

%{--<body>--}%

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>
    <tr>
        <th style="background-color: ${colorProv};">Provincia</th>
        <th style="background-color: ${colorCant};">Cantón</th>
        <th style="background-color: ${colorParr};">Parroquia</th>
        <th>Seleccionar</th>
    </tr>
    </thead>

    <tbody>

    <g:each in="${comunidades}" var="comn" status="i">
        <tr>
            <td class="provincia" style="width: 10%">${comn.provnmbr}</td>
            <td class="canton">${comn.cntnnmbr}</td>
            <td class="parroquia">${comn.parrnmbr}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-xs btn-success btnpq" title="Seleccionar"  id="reg_${i}"
                   parroquia="${comn?.parr__id}" parroquiaN="${comn?.parrnmbr}" provN="${comn?.provnmbr}"
                   canton="${comn?.cntn__id}"  cantN="${comn?.cntnnmbr}">
                    <i class="fa fa-check"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>

</table>

<script type="text/javascript">

    $(".btnpq").click(function () {
        console.log('btn')
        var parroquia = $(this).attr("parroquia");
        var canton = $(this).attr("canton");
        console.log('-->', parroquia, canton)

        $("#hiddenParr").val($(this).attr("parroquia"));
        $("#parrNombre").val($(this).attr("parroquiaN"));
        $("#hiddenCntn").val($(this).attr("canton"));
        $("#cantNombre").val($(this).attr("cantN"));
        $("#provNombre").val($(this).attr("provN"));

//        $("#dlgGeo").dialog("close");
        di.modal("hide");

        return false;
    });

</script>

%{--</body>--}%
%{--</html>--}%