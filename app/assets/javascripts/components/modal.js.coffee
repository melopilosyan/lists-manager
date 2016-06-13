# @cjsx React.DOM

@Modal = React.createClass
  getDefaultProps: ->
    label: 'default-label'
    title: 'Default Title'
    saveText: 'Save'
    renderTo: 'element-id'

  componentDidMount: ->
    log('Modal#componentDidMount')
    $modal = $(ReactDOM.findDOMNode(@))
    $modal.on('hidden.bs.modal', @unMountComponent)
    setTimeout ->
        $modal.modal('show')
      50

  unMountComponent: ->
    ReactDOM.unmountComponentAtNode(ReactDOM.findDOMNode(@).parentNode)

  render: ->
    <div className="modal fade" id={ @props.renderTo + '-itself' } tabindex="-1" role="dialog" aria-labelledby={ @props.label } >
      <div className="modal-dialog" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <h4 className="modal-title" id={ @props.label } >{ @props.title }</h4>
          </div>
          <div className="modal-body">
            { @props.children }
          </div>
          <div className="modal-footer">
            <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" className="btn btn-primary">{ @props.saveText }</button>
          </div>
        </div>
      </div>
    </div>

