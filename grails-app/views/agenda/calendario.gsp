<div class="row">
    <g:if test="${anios}">
        <div class="col-md-12" style="font-weight: bold; margin-top: -5px; margin-bottom: 30px">
            <div class="col-md-4"></div>
            <div class="col-md-1" style="font-size: 14px;">Año</div>
            <div class="col-md-3">
                %{--            <g:select style="font-size:large;" name="anio" class="form-control"   from="${anio - 5..anio + 5}" value="${params.anio}"/>--}%
                <g:select style="font-size:large;" name="anio" class="form-control"   from="${anios}" value="${params.anio}"/>
            </div>
        </div>

        <div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px" id="divCalendario">

        </div>
    </g:if>
    <g:else>
        <div class="col-md-12">
            <div style="text-align: center">
                <i class="fa fa-calendar text-info fa-2x"></i> <strong style="font-size: 16px">El usuario ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '')} no tiene citas médicas agendadas</strong>
            </div>
        </div>
    </g:else>
</div>

<script type="application/javascript">

    cargarTablaCalendario_ajax();

    $("#anio").change(function () {
        cargarTablaCalendario_ajax();
    });

    function cargarTablaCalendario_ajax(){
        var anio = $("#anio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'agenda', action: 'tablaCalendario_ajax')}',
            data:{
                paciente: '${paciente?.id}',
                anio: anio
            },
            success: function (msg) {
                $("#divCalendario").html(msg)
            }
        });
    }

</script>