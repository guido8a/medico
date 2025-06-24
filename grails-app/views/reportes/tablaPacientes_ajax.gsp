<%@ page import="medico.GrupoSanguineo" %>

<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <thead>
        <tr>
            <th style="width: 10%">Cédula</th>
            <th style="width: 15%">Nombres</th>
            <th style="width: 15%">Apellidos</th>
            <th style="width: 17%">Edad</th>
            <th style="width: 7%">Acciones</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <g:each in="${datos}" status="i" var="paciente">
                <tr>
                    <td style="width: 10%">${paciente.pcntcdla}</td>
                    <td style="width: 15%">${paciente.pcntnmbr}</td>
                    <td style="width: 15%">${paciente.pcntapll}</td>
                    <td style="width: 17%">${paciente.edad}</td>
                    <td style="width: 7%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnSeleccionarPaciente" data-id="${paciente?.pcnt__id}"    data-nombre="${paciente?.pcntnmbr}"  data-apellido="${paciente.pcntapll}"  title="Seleccionar paciente">
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                    <td style="width: 1%"></td>
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

    $(".btnSeleccionarPaciente").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        var apellido = $(this).data("apellido");
        $("#paciente").val(id);
        $("#pacienteName").val(apellido + " " + nombre);
        cerrarBuscarPaciente();
    });

</script>

