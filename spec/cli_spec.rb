require 'patchelf/cli'
require 'patchelf/version'

describe PatchELF::CLI do
  it 'print' do
    expect do
      hook_logger do
        described_class.work(%w[--pi --print-needed --print-soname spec/files/pie.elf])
      end
    end.to output(<<-EOS).to_stdout
Interpreter: /lib64/ld-linux-x86-64.so.2
Needed: libstdc++.so.6 libc.so.6
[WARN] No soname, not a shared library?
    EOS
  end

  it 'version' do
    expect { hook_logger { described_class.work(%w[--version]) } }.to output(<<-EOS).to_stdout
PatchELF Version #{PatchELF::VERSION}
    EOS
  end

  it 'no input file' do
    expect { hook_logger { described_class.work(%w[--pi]) } }.to output(
      described_class.__send__(:option_parser).help
    ).to_stdout
  end
end
