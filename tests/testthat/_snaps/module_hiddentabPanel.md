# showBtn creates expect HTML

    Code
      showBtn("id", "Label")
    Output
      <button id="id-show" type="button" class="btn btn-default action-button">Label</button>

# hideBtn creates expected HTML

    Code
      hideBtn("id", "Label")
    Output
      <button id="id-hide" type="button" class="btn btn-default action-button">Label</button>

# wrapPanel creates expected HTML

    Code
      wrapPanel("id", "contents", "btn")
    Output
      <div class="tab-pane" title="id" data-value="id">
        contents
        <div class="row">
          <div class="col-sm-10"></div>
          <div class="col-sm-2">btn</div>
        </div>
      </div>

---

    Code
      wrapPanel("id", "contents", hideBtn("id", "Label"))
    Output
      <div class="tab-pane" title="id" data-value="id">
        contents
        <div class="row">
          <div class="col-sm-10"></div>
          <div class="col-sm-2">
            <button id="id-hide" type="button" class="btn btn-default action-button">Label</button>
          </div>
        </div>
      </div>

---

    Code
      wrapPanel("id", fluidPage(), hideBtn("id", "Label"))
    Output
      <div class="tab-pane" title="id" data-value="id">
        <div class="container-fluid"></div>
        <div class="row">
          <div class="col-sm-10"></div>
          <div class="col-sm-2">
            <button id="id-hide" type="button" class="btn btn-default action-button">Label</button>
          </div>
        </div>
      </div>

