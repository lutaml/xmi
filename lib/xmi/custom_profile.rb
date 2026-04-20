# frozen_string_literal: true

module Xmi
  module CustomProfile
    autoload :Bibliography, "xmi/custom_profile/bibliography"
    autoload :BasicDoc, "xmi/custom_profile/basic_doc"
    autoload :Enumeration, "xmi/custom_profile/enumeration"
    autoload :Ocl, "xmi/custom_profile/ocl"
    autoload :Invariant, "xmi/custom_profile/invariant"
    autoload :PublicationDate, "xmi/custom_profile/publication_date"
    autoload :Edition, "xmi/custom_profile/edition"
    autoload :Number, "xmi/custom_profile/number"
    autoload :YearVersion, "xmi/custom_profile/year_version"
    autoload :Informative, "xmi/custom_profile/informative"
    autoload :Persistence, "xmi/custom_profile/persistence"
    autoload :Abstract, "xmi/custom_profile/abstract"
  end
end
