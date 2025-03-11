import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-surah"
export default class extends Controller {
  static targets = ["ziyadahSurahStart", "ziyadahSurahEnd", "murajaahSurahStart", "murajaahSurahEnd"];

  connect() {
    console.log("Connected")
  }

  updateSurahOptions(event) {
    const selectedJuz = event.target.value;
    const parent = event.target.closest(".collapse-content"); // Get parent container

    if (!parent) return;

    // Determine whether it's Ziyadah or Murajaah
    const isZiyadah = event.target.name.includes("juz_ziyadah");
    const surahStartTarget = isZiyadah
      ? parent.querySelector("select[name*='[ziyadahSurahStart]']")
      : parent.querySelector("select[name*='[murajaahSurahStart]']");
    const surahEndTarget = isZiyadah
      ? parent.querySelector("select[name*='[ziyadahSurahEnd]']")
      : parent.querySelector("select[name*='[murajaahSurahEnd]']");

    if (!surahStartTarget || !surahEndTarget) return;

    console.log(`Fetching Surahs for Juz ${selectedJuz}...`);

    fetch(`/bulk_classroom_sessions/filter_surah?juz=${selectedJuz}`)
      .then(response => response.json())
      .then(data => {
        // Clear existing options
        surahStartTarget.innerHTML = `<option value="">Pilih Surat</option>`;
        surahEndTarget.innerHTML = `<option value="">Pilih Surat</option>`;

        // Populate new options
        data.forEach(surah => {
          const optionStart = new Option(surah.name, surah.id);
          const optionEnd = new Option(surah.name, surah.id);

          surahStartTarget.appendChild(optionStart);
          surahEndTarget.appendChild(optionEnd);
        });
      })
      .catch(error => console.error("Error fetching surahs:", error));
  }
}
