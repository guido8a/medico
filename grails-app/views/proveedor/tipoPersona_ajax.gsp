<g:select id="tipoPersona" name="tipoPersona.id" from="${lista}" optionKey="${{it.id}}" optionValue="${{it.descripcion}}" required="" value="${proveedorInstance?.tipoPersona?.id}"
          class="many-to-one form-control" />

<script type="text/javascript">

    validacionTipoPersona();

    $("#tipoPersona").change(function () {
        validacionTipoPersona();
    });

    function validacionTipoPersona() {
      if($("#tipoPersona option:selected").val() === '1'){
          $("#apellido").addClass("required");
      }else{
          $("#apellido").removeClass("required");
      }
    }

</script>