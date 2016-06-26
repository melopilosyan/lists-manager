# @cjsx React.DOM

@ChangeStateModal = React.createClass
  getInitialState: ->
    close: false
    state: @props.list.state

  changeState: ->
    id = @props.list.id
    $.ajax
      url: LM.R.list(id)
      type: 'PUT'
      data: {list: {state: @state.state}}
      dataType: 'json'
      success: (data) =>
        if data.status == 'ok'
          @setState close: true
          @props.updateChange(id, @state.state, true)
        else
          @setState error: data.msg

  onValueChange: (e) ->
    e.preventDefault()
    @setState state: e.target.value

  hint: ->
    switch @state.state
      when LM.State.Open
        showInfo 'Fully active state. Allows to update, add & edit items.'
      when LM.State.Finalized
        showWarning 'No edits allowed. Change to Open to be able to.'
      when LM.State.Archived
        showError "The archived state. Can't be reverted back. Do you realy want this?"

  selectOptions: ->
    for _, state of LM.State
      <option key={ state } value={ state }>{ state }</option>

  render: ->
    <Modal id='shange-state' buttonText='Change' close={ @state.close }
          title={ 'Change state of ' + @props.list.name } action={ @changeState } >
      { @state.error && showError(@state.error) || @hint() }
      <br/>
      <div className='form-group' >
        <label for='change-list-state'>Change state</label>
        <select id='change-list-state' className='form-control' value={ @state.state } onChange={ @onValueChange } >
          { @selectOptions() }
        </select>
      </div>
    </Modal>


renderModal = (list, updateChange) ->
  ReactDOM.render <ChangeStateModal list={ list } updateChange={ updateChange } />, LM.Modal.container

@changeStateModalLink = (list, updateChange) ->
  linkFor list.state, renderModal.bind(null, list, updateChange)

