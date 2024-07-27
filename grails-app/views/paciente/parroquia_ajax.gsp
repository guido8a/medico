<label class="control-label text-info">
    Parroquia
</label>
<g:select name="parroquia" from="${parroquias}" optionKey="id" optionValue="nombre" class="form-control"
          value="${paciente?.parroquia?.id ?: 1234}"/>