<div>
    <g:select name="periodoLibroDiario" from="${periodos}" optionKey="id" optionValue="${{it.fechaInicio?.format("dd-MM-yyyy") + " - " + it.fechaFin?.format("dd-MM-yyyy")}}" class="form-control" />
</div>