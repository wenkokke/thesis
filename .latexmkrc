use File::Find;
use File::Spec;

# Set the main file
@default_files = ('index.tex');

# Set Skim as the default PDF previewer
$pdf_previewer = 'open -a Skim %S';

# Generate a PDF using XeLaTeX
$pdf_mode = 5;

# Enable Preview Continuous Mode
$preview_continuous_mode = 0;

# Use batchmode
set_tex_cmds('--interaction=batchmode %O %S');

# Add to the list of generated extensions
push @generated_exts, "fdb_latexmk";

# Always view the file via a temporary file
$always_view_file_via_temporary = 1;

# Always analyze the log file
$analyze_input_log_always = 1;

# Ensure that the custom dependencies are cleaned up
$cleanup_includes_cusdep_generated = 1;

# Add the assets directory to the TEXINPUTS environment variable
ensure_path('TEXINPUTS', './assets//');

# Add Pandoc as a custom dependency
add_cus_dep('md', 'tex', 0, 'run_pandoc');
sub run_pandoc {
  my $base = shift @_;

  if ($base eq 'index') {
    # Get sources for custom dependency
    my @sources;
    ## Assets
    push @sources, './assets/templates/default.latex';
    push @sources, './assets/preamble.tex';
    ## Chapters
    find(sub {
        return unless -f;
        return unless /\.(md|tex)$/;
        push @sources, $File::Find::name;
    }, "./chapters");
    ## Scripts
    find(sub {
        return unless -f;
        return unless /\.lua$/;
        push @sources, $File::Find::name;
    }, "./scripts");
    ## Configuration
    push @sources, './index.defaults.yaml';

    # Set sources for custom dependency
    rdb_set_source($rule, @sources);

    # Run Pandoc
    return system('pandoc', '-H', 'preamble.tex', '-d', 'index.defaults.yaml', "$base.md", '-o', "$base.tex");
  };
}
