<div class="form-group">
    <span class="grupo">
        <label class="col-md-1 control-label text-info">
            Tipo de examen
        </label>
        <span class="col-md-4">
            <g:select name="tipoExamen" from="${tipos}" optionKey="id" class="form-control" value="${examenComplementario?.examen?.tipoExamen?.id}"
                      optionValue="descripcion"/>
            <p class="help-block ui-helper-hidden"></p>
        </span>
    </span>
</div>

<div id="divExamen">

</div>

<script type="text/javascript">

    cargarExamen($("#tipoExamen option:selected").val())

    $("#tipoExamen").change(function () {
        var tipo = $(this).val();
        cargarExamen(tipo);
    });

    function cargarExamen(tipo){
        var examen = '${examen?.id}'
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'examen', action: 'examen_ajax')}',
            data:{
                tipo: tipo,
                examen: examen
            },
            success: function (msg){
                $("#divExamen").html(msg)
            }
        })
    }

</script>