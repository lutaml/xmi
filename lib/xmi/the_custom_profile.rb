# frozen_string_literal: true

module Xmi
  module TheCustomProfile
    class Bibliography < Lutaml::Model::Serializable
      attribute :base_class, :string

      xml do
        root "Bibliography"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Class", to: :base_class
      end
    end

    class BasicDoc < Lutaml::Model::Serializable
      attribute :base_class, :string

      xml do
        root "BasicDoc"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Class", to: :base_class
      end
    end

    class Enumeration < Lutaml::Model::Serializable
      attribute :base_enumeration, :string

      xml do
        root "enumeration"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Enumeration", to: :base_enumeration
      end
    end

    class Ocl < Lutaml::Model::Serializable
      attribute :base_constraint, :string

      xml do
        root "OCL"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Constraint", to: :base_constraint
      end
    end

    class Invariant < Lutaml::Model::Serializable
      attribute :base_constraint, :string

      xml do
        root "invariant"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Constraint", to: :base_constraint
      end
    end

    class PublicationDate < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :publication_date, :string

      xml do
        root "publicationDate"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "publicationDate", to: :publication_date
      end
    end

    class Edition < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :edition, :string

      xml do
        root "edition"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "edition", to: :edition
      end
    end

    class Number < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :number, :string

      xml do
        root "number"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "number", to: :number
      end
    end

    class YearVersion < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :year_version, :string

      xml do
        root "yearVersion"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "yearVersion", to: :year_version
      end
    end

    class Informative < Lutaml::Model::Serializable
      attribute :base_package, :string

      xml do
        root "informative"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
      end
    end

    class Persistence < Lutaml::Model::Serializable
      attribute :base_class, :string
      attribute :base_enumeration, :string
      attribute :persistence, :string

      xml do
        root "persistence"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Class", to: :base_class
        map_attribute "base_Enumeration", to: :base_enumeration
        map_attribute "persistence", to: :persistence
      end
    end

    class Abstract < Lutaml::Model::Serializable
      attribute :base_class, :string

      xml do
        root "Abstract"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Class", to: :base_class
      end
    end
  end
end
