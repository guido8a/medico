<g:select name="citaSeleccionada" from="${citas}" optionValue="${{it?.fecha?.format("dd-MMM-yyyy HH:mm") + " - " + it?.motivo}}"
          optionKey="id" class="form-control" value="${cita?.id}" />

<script type="text/javascript">
    cargarUltimaCita($("#citaSeleccionada option:selected").val());
    cargarBotones($("#citaSeleccionada option:selected").val());
    cargarEstado($("#citaSeleccionada option:selected").val());

    $("#citaSeleccionada").change(function () {
        var cita = $(this).val();
        cargarUltimaCita(cita);
        cargarBotones(cita);
        cargarEstado(cita);
    });
</script>