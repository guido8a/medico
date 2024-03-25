
<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 15%;">Código</th>
            <th style="width: 45%;">Descripción</th>
            <th style="width: 17%;">Presentación</th>
            <th style="width: 13%;">Concentración</th>
            <th style="width: 10%;">Seleccionar</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 500px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" var="dato" status="i">
            <tr style="width: 100%;">
                <td style="width: 15%;">${dato.mdcncdgo}</td>
                <td style="width: 45%;">${dato.mdcndscr}</td>
                <td style="width: 17%;">${dato.mdcnfrma}</td>
                <td style="width: 13%;">${dato.mdcncnct}</td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSelPadre" title="Seleccionar" data-id="${dato.mdcn__id}" data-nombre="${dato.mdcndscr}" data-codigo="${dato.mdcncdgo}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnSelPadre").click(function () {
        var id = $(this).data("id");
        var codigo = $(this).data("codigo");
        var descripcion = $(this).data("nombre");

        $("#padre").val(id);
        $("#nombrePadre").val(codigo + " - " + descripcion);

        cerrarPadre();

        return false;
    });

</script>
