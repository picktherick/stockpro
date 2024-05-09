require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "should create client" do
    visit clients_url
    click_on "New client"

    fill_in "Birth date", with: @client.birth_date
    fill_in "City", with: @client.city
    fill_in "Complement", with: @client.complement
    fill_in "Identity document number", with: @client.identity_document_number
    fill_in "Name", with: @client.name
    fill_in "Neighborhood", with: @client.neighborhood
    fill_in "Number", with: @client.number
    fill_in "Observations", with: @client.observations
    fill_in "Phone number", with: @client.phone_number
    fill_in "State", with: @client.state
    fill_in "Street", with: @client.street
    fill_in "Zipcode", with: @client.zipcode
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "should update Client" do
    visit client_url(@client)
    click_on "Edit this client", match: :first

    fill_in "Birth date", with: @client.birth_date
    fill_in "City", with: @client.city
    fill_in "Complement", with: @client.complement
    fill_in "Identity document number", with: @client.identity_document_number
    fill_in "Name", with: @client.name
    fill_in "Neighborhood", with: @client.neighborhood
    fill_in "Number", with: @client.number
    fill_in "Observations", with: @client.observations
    fill_in "Phone number", with: @client.phone_number
    fill_in "State", with: @client.state
    fill_in "Street", with: @client.street
    fill_in "Zipcode", with: @client.zipcode
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "should destroy Client" do
    visit client_url(@client)
    click_on "Destroy this client", match: :first

    assert_text "Client was successfully destroyed"
  end
end
