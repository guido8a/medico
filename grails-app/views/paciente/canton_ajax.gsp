<%@ page import="geografia.Canton" %>
<label class="control-label text-info">
    Cantón
</label>
<g:select name="canton" from="${cantones}" optionKey="id" optionValue="nombre" class="form-control"
          value="${paciente?.parroquia?.canton?.id ?: 178}"/>

<script type="text/javascript">

    $("#canton").change(function () {
        var canton = $(this).val();
        cargarParroquia(canton);
    });

    cargarParroquia($("#canton option:selected").val());

    function cargarParroquia(canton) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'parroquia_ajax')}',
            data:{
                id: '${paciente?.id}',
                canton: canton
            },
            success: function (msg) {
                $("#divParroquia").html(msg)
            }
        });
    }
</script>
