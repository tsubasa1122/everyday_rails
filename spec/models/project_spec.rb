require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'does not allow duplicate project names per user' do
    user = User.create(
      first_name: "nakano",
      last_name: "tsubasa",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(
      name: "Test Project",
    )
    new_project = Project.new(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it 'allows two users to share a project name' do
    user = User.create(
      first_name: "nakano",
      last_name: "tsubasa",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.projects.create(
      name: "Test Project",
    )

    other_user = User.create(
      first_name: "tanaka",
      last_name: "takeshi",
      email: "joeteste2r@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    other_project = other_user.projects.build(
      name: "Test Project",
    )
    expect(other_project).to be_valid
  end
end
