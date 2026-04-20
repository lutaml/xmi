# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Links < Lutaml::Model::Serializable
        attribute :association, Association, collection: true
        attribute :generalization, Generalization, collection: true
        attribute :note_link, NoteLink, collection: true

        xml do
          root "links"

          map_element "Association", to: :association, value_map: VALUE_MAP
          map_element "Generalization", to: :generalization,
                                        value_map: VALUE_MAP
          map_element "NoteLink", to: :note_link, value_map: VALUE_MAP
        end
      end
    end
  end
end
