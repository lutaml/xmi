# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<interfaceRealization>` element — a typed relationship
    # between a Class and an Interface it implements. Distinct from
    # the generic Realization element in Sparx XMI; using the typed
    # element preserves the implementing-class ↔ Interface contract
    # information that would otherwise be collapsed into a generic
    # `packagedElement type="uml:Realization"`.
    class InterfaceRealization < Base
      attribute :name, :string
      attribute :client, :string
      attribute :supplier, :string
      attribute :contract, :string

      xml do
        root "interfaceRealization"
        map_attribute "name", to: :name
        map_attribute "client", to: :client
        map_attribute "supplier", to: :supplier
        map_attribute "contract", to: :contract
      end
    end
  end
end
