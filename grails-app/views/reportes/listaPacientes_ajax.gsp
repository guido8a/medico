<div class="modal-contenido">
    <div class="form-group keeptogether">
        <div class="col-md-6">
            <span class="grupo">
                <label for="consultorio" class="col-md-4 control-label">
                    Consultorio
                </label>

                <div class="col-md-12">
                    <g:select name="consultorio" from="${seguridad.Empresa.list().sort{it.nombre}}" class="form-control" optionKey="id" optionValue="nombre"/>
                </div>
            </span>
        </div>
    <div class="col-md-6">
        <span class="grupo">
            <label class="col-md-2 control-label">
                Paciente
            </label>

            <div class="col-md-12" id="divPacientes">

            </div>
        </span>
    </div>
    </div>
</div>

<script type="text/javascript">

    cargarPacientes($("#consultorio option:selected").val());

    function cargarPacientes(consultorio) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'pacientes_ajax')}',
            data:{
                id: consultorio
            },
            success: function (msg){
                $("#divPacientes").html(msg)
            }
        })
    }

    $("#consultorio").change(function () {
        var consultorio = $(this).val()
        cargarPacientes(consultorio);
    })


</script>