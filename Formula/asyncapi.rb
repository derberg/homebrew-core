require "language/node"

class Asyncapi < Formula
  desc "All in one CLI for all AsyncAPI tools"
  homepage "https://github.com/asyncapi/cli"
  url "https://registry.npmjs.org/@asyncapi/cli/-/cli-0.11.2.tgz"
  sha256 "75e4d0e73f0ea8693ccfa684c3fd5ca26cab4f4a634c9064b90520093df882bc"
  license "Apache-2.0"

  depends_on "node"

  def install
    inreplace "package.json", "postpack", "postpack_disabled"
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
    rm libexec/"lib/node_modules/@asyncapi/cli/oclif.manifest.json"
  end

  test do
    system bin/"asyncapi", "new", "--file-name=asyncapi.yml", "--example=default-example.yaml", "--no-tty"
    assert_predicate testpath/"asyncapi.yml", :exist?, "AsyncAPI file was not created"
  end
end
