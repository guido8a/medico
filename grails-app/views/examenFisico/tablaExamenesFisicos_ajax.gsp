<g:if test="${examenes.size() > 0}">
    <div id="list-DocumentoProceso" role="main">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr style="width: 100%">
                <th style="width: 80%">Fecha </th>
                <th style="width: 20%">Acciones </th>
            </tr>
            </thead>
            <tbody >

            <g:each in="${examenes}" status="i" var="examen">
                <tr style="width: 100%">
                    <td style="width: 80%; text-align: center">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width:20%; text-align: center">
                        <a class="btn btn-success btn-xs btn-edit btn-ajax" href="#" rel="tooltip" title="Ir al examen físico" data-id="${examen.id}">
                            <i class="fa fa-clipboard-check"></i>
                        </a>
                        <a class="btn btn-danger btn-xs btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${examen.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</g:if>
<g:else>
    <div class="alert alert-warning"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen exámenes físicos</div>
</g:else>

<script type="text/javascript">

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    }); //click btn edit

    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRowEF(id)
    });

</script>