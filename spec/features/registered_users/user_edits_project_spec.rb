require "rails_helper"

describe "User can edit their project" do
  it "User is able to edit their project" do

    category = create(:category)
    project = create(:project, category_id: category.id)

    visit project_path(project.slug)

    click_on "Edit Your Project"

    expect(current_path).to eq(edit_project_path(project.slug))

    fill_in "project[title]", with: "The New Hotness"

    click_on "Update"

    expect(current_path).to eq(project_path(Project.first.title.parameterize))
    expect(page).to have_content("The New Hotness")
  end

  it "User MUST have all info to edit their project" do

    category = create(:category)
    project = create(:project, category_id: category.id)

    visit project_path(project.slug)

    click_on "Edit Your Project"

    expect(current_path).to eq(edit_project_path(project.slug))
save_and_open_page
    fill_in "project[description]", with: nil

    click_on "Update"

    expect(page).to have_content("Edit Your Project")
  end
end
