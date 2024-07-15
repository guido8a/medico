<a href="#" class="btn btn-warning" id="btnNuevaCita" title="Agendar próxima cita" >
    <i class="fas fa-plus"></i> Agendar Cita
</a>
<a href="#" class="btn btn-info" id="btnImprimirReceta" title="Imprimir receta de la cita">
    <i class="fas fa-print"></i> Imprimir receta
</a>

<g:if test="${cita?.estado == 'A'}">
    <a href="#" class="btn btn-success" id="btnTerminarCita" title="Finalizar la cita" >
        <i class="fas fa-check"></i> Finalizar Cita
    </a>
    <a href="#" class="btn btn-danger" id="btnDarBajaCita" title="Dar de baja la cita" >
        <i class="fas fa-trash"></i> Dar de baja Cita
    </a>
</g:if>

<script type="text/javascript">

    $("#btnDarBajaCita").click(function() {
        borrarCita();
    });

    $("#btnTerminarCita").click(function() {
        finalizarCita();
    });

    $("#btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'agenda', action: 'agenda')}?paciente=" + '${cita?.paciente?.id}'
    });

    $("#btnImprimirReceta").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        openLoader("Cargando...");
        location.href = "${g.createLink(controller:'reportes', action: 'receta')}?cita=" + cita
    });

</script>