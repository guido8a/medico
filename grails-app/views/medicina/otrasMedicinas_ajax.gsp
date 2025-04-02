<div class="row">
    <div class="col-md-12">
        <g:select name="nueva" from="${todas}" optionKey="${{it.id}}" optionValue="${{it?.codigo ? (it?.codigo + " - " + it.descripcion) :it.descripcion }}" class="form-control" />
    </div>
</div>