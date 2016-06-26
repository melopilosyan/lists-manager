# @cjsx React.DOM

@List = React.createClass
  updateList: (id, newValue, stateChanged) ->
    list = $.extend true, {}, @props.list
    list[stateChanged && 'state' || 'name'] = newValue
    @props.updateLists list, false, stateChanged

  render: ->
    list = @props.list
    allowChangeStatus = @props.authenticated && list.allowActions && !list.stateArchived()

    <tr>
      <th className='text-center'>{ @props.index }</th>
      <td>{ linkFor(list.name, showListDetails.bind(null, list, @props.allowEdit, @props.updateLists)) }</td>
      <td>{ list.creator.name }</td>
      <td>{ list.madeOn }</td>
      <td>{ if allowChangeStatus then changeStateModalLink(list, @updateList) else list.state }</td>
      <td width="55" className='text-center' >
        { @props.authenticated && actionIconsFor(
            @props.list
            @props.updateLists
            @props.allowEdit && list.stateOpen() && @updateList) }
      </td>
    </tr>

