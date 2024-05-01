<a href="#" class="btn btn-warning" id="btnNuevaCita" title="Agendar próxima cita" >
    <i class="fas fa-plus"></i> Agendar Cita
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
    })

    $("#btnTerminarCita").click(function() {
        finalizarCita();
    })

</script>