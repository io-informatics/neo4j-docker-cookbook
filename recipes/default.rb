include_recipe "docker"

# Pull docker image
docker_image node[:neo4j][:docker_image] do
	tag node[:neo4j][:docker_image_tag]
	action :pull
end

# Cread volumens directory
directory node[:neo4j][:data_path] do
	recursive true
	action :create
end

# Run the docker container
docker_container "neo4j" do
	action :run
	image node[:neo4j][:docker_image]
	container_name node[:neo4j][:docker_container]
	detach true
	port ['7474:7474', '1337:1337']
	volume [
		"#{node[:neo4j][:data_path]}:#{node[:neo4j][:container_data_path]}"]
end
