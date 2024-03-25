
<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <thead>
        <tr>
            <th style="width: 13%;">Código</th>
            <th style="width: 40%;">Descripción</th>
            <th style="width: 25%;">Presentación</th>
            <th style="width: 10%;">Concentración</th>
            <th style="width: 12%;">Seleccionar</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" var="dato" status="i">
            <tr>
                <td style="width: 13%;">${dato.mdcncdgo}</td>
                <td style="width: 40%;">${dato.mdcndscr}</td>
                <td style="width: 25%;">${dato.mdcnfrma}</td>
                <td style="width: 10%;">${dato.mdcncnct}</td>
                <td style="width: 13%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSelMedicina" title="Seleccionar" data-id="${dato.mdcn__id}" data-nombre="${dato.mdcndscr}" data-codigo="${dato.mdcncdgo}" data-con="${dato.mdcncnct}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnSelMedicina").click(function () {
        var id = $(this).data("id");
        var codigo = $(this).data("codigo");
        var descripcion = $(this).data("nombre");
        var concentracion = $(this).data("con");

        $("#medicina").val(id);
        $("#medicinaNombre").val(descripcion);
        $("#medicinaCodigo").val(codigo);
        $("#medicinaConcentracion").val(concentracion);

        cerrarMedicina();

        return false;
    });

</script>
