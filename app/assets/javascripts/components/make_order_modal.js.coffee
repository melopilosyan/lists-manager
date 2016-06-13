# @cjsx React.DOM

@MakeOrderModal = React.createClass
  getInitialState: ->
    showModal: false

  open: ->
    @setState showModal: true

  close: ->
    @setState showModal: false

  render: ->
    <div className="jumbotron">
      This is a modal
    </div>

