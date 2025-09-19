<div class="row">
    <div class="col-md-11 breadcrumb">
        <label class="col-md-12" style="font-size: 20px">4.-Forma de pago</label>
        <div class="col-md-4 tamano bd">
            Forma de Pago
        </div>
        <div class="col-md-8 tamano ">
            <g:select name="formaPago" from="${sri.FormaDePago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control" />
        </div>
    </div>
    <div class="btn-group col-md-1">
        <a href="#" class="btn btn-sm btn-success btnEditarFormaDePago" title="Editar forma de pago">
            <i class="fas fa-edit"></i> Editar
        </a>
    </div>
</div>

