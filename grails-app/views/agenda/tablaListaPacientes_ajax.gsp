
<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <thead>
        <tr>
            <th style="width: 13%;">Apellidos</th>
            <th style="width: 30%;">Nombres</th>
            <th style="width: 25%;">Cédula</th>
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
                    <td style="width: 13%;">${dato.pcntapll}</td>
                    <td style="width: 30%;">${dato.pcntnmbr}</td>
                    <td style="width: 25%;">${dato.pcntcdla}</td>
                    <td style="width: 13%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnSelPaciente" title="Seleccionar" data-id="${dato.pcnt__id}"
                           data-nombre="${dato.pcntapll + " " + dato.pcntnmbr}">
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

    $(".btnSelPaciente").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");

        $("#paciente").val(id);
        $("#pacienteNombre").val(nombre);

        cerrarBusquedaPaciente();

        return false;
    });

</script>
