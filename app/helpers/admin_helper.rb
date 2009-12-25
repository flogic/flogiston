module AdminHelper
  def self.register_section(section)
    const_set(:ADMIN_SECTIONS, []) unless const_defined?(:ADMIN_SECTIONS)
    ADMIN_SECTIONS.push section if section
    ADMIN_SECTIONS.uniq!
  end

  def admin_sections
    ADMIN_SECTIONS
  end

  register_section(nil)
end
