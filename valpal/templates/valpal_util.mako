<%def name="sentence_list(sentences)">
  <table class="example-list">
    % for sentence in sentences:
    <tr>
      <td>(${h.link(request, sentence, label=sentence.number)})</td>
      <td>
        <p>${h.rendered_sentence(sentence)}</p>
        % if sentence.comment:
        <p><i>Comment</i>: ${sentence.comment}</p>
        % endif
        % if sentence.references:
        <p>See ${h.linked_references(request, sentence)|n}</p>
        % endif
      </td>
    </tr>
    % endfor
  </table>
</%def>
