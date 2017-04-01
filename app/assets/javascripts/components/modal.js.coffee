# @cjsx React.DOM

@Modal = React.createClass
  getDefaultProps: ->
    id:         'modal'
    title:      'Title'
    close:      false
    action:     false
    buttonText: 'OK'
    disableAction: false

  componentDidMount: ->
    $modal = $(ReactDOM.findDOMNode(@))
    $modal.on('hidden.bs.modal', @unMountComponent)
    $modal.on('shown.bs.modal', => $modal.find('input:first').focus())
    $modal.modal('show')

  shouldComponentUpdate: (props) ->
    props.close && $(ReactDOM.findDOMNode(@)).find('.close').click()
    !props.close

  unMountComponent: ->
    ReactDOM.unmountComponentAtNode(ReactDOM.findDOMNode(@).parentNode)

  onActionClick: (e) ->
    e.preventDefault()
    @props.disableAction || @props.action()

  showActionButton: ->
    btnClass = 'btn btn-primary' + (@props.disableAction && ' disabled' || '')
    <button type="button" className={ btnClass } onClick={ @onActionClick } >
      { @props.buttonText }
    </button>

  render: ->
    label = @props.id + '-m-label'

    <div className="modal fade" id={ @props.id + '-itself' } tabIndex="-1" role="dialog" aria-labelledby={ label } >
      <div className="modal-dialog" role="document" >
        <div className="modal-content" >
          <div className="modal-header" >
            <button type="button" className="close" data-dismiss="modal" aria-label="Close" >
              <span aria-hidden="true">&times;</span>
            </button>
            <h1 className="modal-title" id={ label }>
              <small>{ @props.title }</small>
            </h1>
          </div>
          <div className="modal-body" >
            { @props.children }
          </div>
          <div className="modal-footer" >
            <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            { @props.action && @showActionButton() }
          </div>
        </div>
      </div>
    </div>

