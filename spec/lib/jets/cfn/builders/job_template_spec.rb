require "spec_helper"

describe Jets::Cfn::Builders::JobTemplate do
  let(:builder) do
    Jets::Cfn::Builders::JobTemplate.new(app_class)
  end
  let(:app_class) do
    HardJob
  end

  describe "compose" do
    it "builds a child stack with the scheduled events" do
      builder.compose

      # puts builder.text # uncomment to see template text

      template = builder.template
      resources = template["Resources"]

      expect(resources).to include("HardJobDigLambdaFunction")
      expect(resources).to include("HardJobDigScheduledEvent")
      expect(resources).to include("HardJobDigPermissionEventsRule")

      expect(builder.template_path).to eq "#{Jets.tmp_build}/templates/demo-dev-2-hard-job.yml"
    end
  end
end