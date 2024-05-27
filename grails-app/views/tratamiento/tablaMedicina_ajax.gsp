
<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <thead>
        <tr>
            <th style="width: 13%;">Nombre</th>
            <th style="width: 30%;">Descripción</th>
            <th style="width: 25%;">Presentación</th>
            <th style="width: 10%;">Concentración</th>
            <th style="width: 10%;">Cantidad</th>
            <th style="width: 12%;">Seleccionar</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <g:each in="${datos}" var="dato" status="i">
                <tr>
                    <td style="width: 13%;">${dato.mdcnnmbr}</td>
                    <td style="width: 30%;">${dato.mdcndscr}</td>
                    <td style="width: 25%;">${dato.mdcnfrma}</td>
                    <td style="width: 10%;">${dato.mdcncnct}</td>
                    <td style="width: 10%;">${dato.mdcncntd}</td>
                    <td style="width: 13%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnSelMedicina" title="Seleccionar" data-id="${dato.mdcn__id}"
                           data-nombre="${dato.mdcndscr}" data-codigo="${dato.mdcncdgo}" data-con="${dato.mdcncnct}" data-can="${dato.mdcncntd}" data-obs="${dato.mdcnobsr}">
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

    $(".btnSelMedicina").click(function () {
        var id = $(this).data("id");
        var codigo = $(this).data("codigo");
        var descripcion = $(this).data("nombre");
        var concentracion = $(this).data("con");
        var cantidad = $(this).data("can")
        var observaciones = $(this).data("obs")

        $("#medicina").val(id);
        $("#medicinaNombre").val(descripcion);
        $("#medicinaCodigo").val(codigo);
        $("#medicinaConcentracion").val(concentracion);
        $("#cantidad").val(cantidad);
        $("#descripcion").val(observaciones);

        cerrarMedicina();

        return false;
    });

</script>
